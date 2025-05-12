#!/bin/bash

PORT=8080
TMP="tmp_response.txt"
ALLOWED_HOST="192.168.11.21"
URL="http://localhost:$PORT/img/image1.png"

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
    rm -f "$TMP"
    exit 1
  fi

  echo "----"
}

echo "========== ✅ 通常モードテスト =========="
mv ./nginx/conf.d/maintenance_on ./nginx/conf.d/maintenance_off
echo "====not allowed ===="
test_url "http://localhost:$PORT/" 200 "[/]"
test_url "http://localhost:$PORT/img/image1.png" 200 "[/img/image1.png]"
test_url "http://localhost:$PORT/img/image2.png" 200 "[/img/image2.png]"
test_url "http://localhost:$PORT/test" 200 "[/test]"
test_url "http://localhost:$PORT/get_friend_list?id=1" 200 "[/get_friend_list?id=1]"
test_url "http://localhost:$PORT/get_friend_of_friend_list?id=1" 200 "[/get_friend_of_friend_list?id=1]"
test_url "http://localhost:$PORT/get_friend_of_friend_list_paging?id=1&limit=2&page=1" 200 "[/get_friend_of_friend_list_paging?id=1&limit=2&page=1]"
test_url "http://localhost:$PORT/get_friend_list?invalid_param" 400 "[/get_friend_list?invalid_param]"
test_url "http://localhost:$PORT/none" 404 "[/none]"
echo "==== allowed ===="
test_url "http://$ALLOWED_HOST:$PORT/" 200 "[/]"
test_url "http://$ALLOWED_HOST:$PORT/img/image1.png" 200 "[/img/image1.png]"
test_url "http://$ALLOWED_HOST:$PORT/img/image2.png" 200 "[/img/image2.png]"
test_url "http://$ALLOWED_HOST:$PORT/test" 200 "[/test]"
test_url "http://$ALLOWED_HOST:$PORT/get_friend_list?id=1" 200 "[/get_friend_list?id=1]"
test_url "http://$ALLOWED_HOST:$PORT/get_friend_of_friend_list?id=1" 200 "[/get_friend_of_friend_list?id=1]"
test_url "http://$ALLOWED_HOST:$PORT/get_friend_of_friend_list_paging?id=1&limit=2&page=1" 200 "[/get_friend_of_friend_list_paging?id=1&limit=2&page=1]"
test_url "http://$ALLOWED_HOST:$PORT/get_friend_list?invalid_param" 400 "[/get_friend_list?invalid_param]"
test_url "http://$ALLOWED_HOST:$PORT/none" 404 "[/none]"

echo "========== 🔧 キャッシュテスト =========="
expected_header="Cache-Control: public, max-age=86400"

headers=$(curl -sI "$URL")

echo "$headers" | grep -i "Cache-Control"

if echo "$headers" | grep -iq "$expected_header"; then
  echo "[PASS] Cache-Control 正常: $expected_header"
else
  echo "[FAIL] Cache-Control 不一致"
  exit 1
fi

echo "========== 🔧 メンテナンステスト =========="
mv ./nginx/conf.d/maintenance_off ./nginx/conf.d/maintenance_on
sleep 1
echo "====not allowed ===="
test_url "http://localhost:$PORT/" 503 "[/]"
test_url "http://localhost:$PORT/img/image1.png" 503 "[/img/image1.png]"
test_url "http://localhost:$PORT/img/image2.png" 503 "[/img/image2.png]"
test_url "http://localhost:$PORT/test" 200 "[/test]"
test_url "http://localhost:$PORT/get_friend_list?id=1" 503 "[/get_friend_list?id=1]"
test_url "http://localhost:$PORT/get_friend_of_friend_list?id=1" 503 "[/get_friend_of_friend_list?id=1]"
test_url "http://localhost:$PORT/get_friend_of_friend_list_paging?id=1&limit=2&page=1" 503 "[/get_friend_of_friend_list_paging?id=1&limit=2&page=1]"
test_url "http://localhost:$PORT/get_friend_list?invalid_param" 503 "[/get_friend_list?invalid_param]"
echo "==== allowed ===="
test_url "http://$ALLOWED_HOST:$PORT/" 200 "[/]"
test_url "http://$ALLOWED_HOST:$PORT/img/image1.png" 200 "[/img/image1.png]"
test_url "http://$ALLOWED_HOST:$PORT/img/image2.png" 200 "[/img/image2.png]"
test_url "http://$ALLOWED_HOST:$PORT/test" 200 "[/test]"
test_url "http://$ALLOWED_HOST:$PORT/get_friend_list?id=1" 200 "[/get_friend_list?id=1]"
test_url "http://$ALLOWED_HOST:$PORT/get_friend_of_friend_list?id=1" 200 "[/get_friend_of_friend_list?id=1]"
test_url "http://$ALLOWED_HOST:$PORT/get_friend_of_friend_list_paging?id=1&limit=2&page=1" 200 "[/get_friend_of_friend_list_paging?id=1&limit=2&page=1]"
test_url "http://$ALLOWED_HOST:$PORT/get_friend_list?invalid_param" 400 "[/get_friend_list?invalid_param]"
test_url "http://$ALLOWED_HOST:$PORT/none" 404 "[/none]"

rm -f "$TMP"

echo "✅ finish"
