SELECT
    rpad(md5, length(sha256), '1') as md5,
    lpad(sha1, length(sha256), '0') as sha1,
    sha256
FROM
    encription;
