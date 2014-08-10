From: =?ISO-8859-1?Q?Jo=EBl_Kr=E4hemann?= <weedlight@gmail.com>
Subject: fast additive copy and morph functions
Date: Sun, 10 Aug 2014 08:00:53 +0200
Message-ID: <1407650453.15843.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
 [74.125.82.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 5ABAA261AF0
 for <alsa-devel@alsa-project.org>; Sun, 10 Aug 2014 08:01:11 +0200 (CEST)
Received: by mail-we0-f173.google.com with SMTP id q58so7321538wes.4
 for <alsa-devel@alsa-project.org>; Sat, 09 Aug 2014 23:01:11 -0700 (PDT)
Received: from [192.168.42.170] (201-227.197-178.cust.bluewin.ch.
 [178.197.227.201])
 by mx.google.com with ESMTPSA id wr6sm14947268wjc.24.2014.08.09.23.01.09
 for <alsa-devel@alsa-project.org>
 (version=SSLv3 cipher=RC4-SHA bits=128/128);
 Sat, 09 Aug 2014 23:01:10 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

RG9lcyBzb21lb25lIGhvdyB0byBkbyBmYXN0IGFkZGl0aXZlIGNvcHkgYW5kIG1vcnBoIGZ1bmN0
aW9ucz8KClRoaXMgaXMgdGhlIGhlYWRlciBvZiB0aGUgY29ycmVzcG9uZGluZyAqLmMgZmlsZQoK
aHR0cHM6Ly9zb3VyY2Vmb3JnZS5uZXQvcC9hZ3MvY29kZS9IRUFEL3RyZWUvc3JjL2Fncy9hdWRp
by9hZ3NfYXVkaW9fc2lnbmFsLmgKaHR0cHM6Ly9zb3VyY2Vmb3JnZS5uZXQvcC9hZ3MvY29kZS9I
RUFEL3RyZWUvc3JjL2Fncy9hdWRpby9hZ3NfYXVkaW9fc2lnbmFsLmMKCllvdXIgY29udHJpYnV0
aW9uIHdpbGwgYmUgbm90ZWQgaW4gdGhlc2UgZmlsZXMhCgpiZXN0IHJlZ2FyZHMKSm/Dq2wKCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
