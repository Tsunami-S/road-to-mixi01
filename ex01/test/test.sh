#!/bin/bash

PORT=8080
TMP="tmp_response.txt"

function test_url() {
  url=$1
  expected_status=$2
  description=$3

  status=$(curl -s -o "$TMP" -w "%{http_code}" "$url")
  echo "📎 $description: $url"

  if [ "$status" == "$expected_status" ]; then
    echo "[PASS] → $status"
  else
    echo "[FAIL] → Expected $expected_status but got $status"
    cat "$TMP"
    exit 1
  fi

  echo "----"
}

echo "========== ✅ 通常モードテスト =========="
mv ./nginx/conf.d/maintenance_on ./nginx/conf.d/maintenance_off
test_url "http://localhost:$PORT/" 200 "[/]"
test_url "http://localhost:$PORT/img/image1.png" 200 "[/img/image1.png]"
test_url "http://localhost:$PORT/img/image2.png" 200 "[/img/image2.png]"
test_url "http://localhost:$PORT/test" 200 "[/test]"
test_url "http://localhost:$PORT/get_friend_list?id=1" 200 "[/get_friend_list?id=1]"
test_url "http://localhost:$PORT/get_friend_of_friend_list?id=1" 200 "[/get_friend_of_friend_list?id=1]"
test_url "http://localhost:$PORT/get_friend_of_friend_list_paging?id=1&limit=2&page=1" 200 "[/get_friend_of_friend_list_paging?id=1&limit=2&page=1]"
test_url "http://localhost:$PORT/none" 404 "[/none]"

echo "========== 🔧 メンテナンステスト =========="
mv ./nginx/conf.d/maintenance_off ./nginx/conf.d/maintenance_on
sleep 1
test_url "http://localhost:$PORT/" 503 "[/]"
test_url "http://localhost:$PORT/img/image1.png" 503 "[/img/image1.png]"
test_url "http://localhost:$PORT/img/image2.png" 503 "[/img/image2.png]"
test_url "http://localhost:$PORT/test" 503 "[/test]"
test_url "http://localhost:$PORT/get_friend_list?id=1" 503 "[/get_friend_list?id=1]"
test_url "http://localhost:$PORT/get_friend_of_friend_list?id=1" 503 "[/get_friend_of_friend_list?id=1]"
test_url "http://localhost:$PORT/get_friend_of_friend_list_paging?id=1&limit=2&page=1" 503 "[/get_friend_of_friend_list_paging?id=1&limit=2&page=1]"
test_url "http://localhost:$PORT/get_friend_list?invalid_param" 503 "[/get_friend_list?invalid_param]"

rm -f "$TMP"
echo "✅ finish"
