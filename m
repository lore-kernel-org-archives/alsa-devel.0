From: =?ISO-8859-1?Q?S=E9rgio?= Basto <sergio@serjux.com>
Subject: [Fwd: [kde] Low maximum volume with pulseaudio on kde]
Date: Sat, 18 Jun 2011 15:14:57 +0100
Message-ID: <1308406497.32022.4.camel@segulix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sapo.pt (relay3.ptmail.sapo.pt [212.55.154.23])
	by alsa0.perex.cz (Postfix) with SMTP id 4F1A51037FC
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Jun 2011 16:15:05 +0200 (CEST)
Received: from unknown (HELO sergiomb.no-ip.org)
	(sergiomb@sapo.pt@[188.83.218.192])
	(envelope-sender <sergio@serjux.com>)
	by mta13 (qmail-ptmail-1.0.0) with AES256-SHA encrypted SMTP
	for <alsa-devel@alsa-project.org>; 18 Jun 2011 14:14:59 -0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa ML <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

LS0tLS0tLS0gRm9yd2FyZGVkIE1lc3NhZ2UgLS0tLS0tLS0KRnJvbTogU8OpcmdpbyBCYXN0byA8
c2VyZ2lvQHNlcmp1eC5jb20+ClJlcGx5LXRvOiBrZGVAbWFpbC5rZGUub3JnClRvOiBLREUgTUwg
PGtkZUBtYWlsLmtkZS5vcmc+ClN1YmplY3Q6IFtrZGVdIExvdyBtYXhpbXVtIHZvbHVtZSB3aXRo
IHB1bHNlYXVkaW8gb24ga2RlCkRhdGU6IFdlZCwgMTUgSnVuIDIwMTEgMjM6MDQ6MjYgKzAxMDAK
CkhpLCB0cnkgYWdhaW4sCgoxc3QgLSBlZGl0IC9ldGMvcHVsc2UvY2xpZW50LmNvbmYKYW5kIGNo
YW5nZSAKYXV0b3NwYXduID0gbm8KCjJuZCAtIGtpbGxhbGwgcHVsc2VhdWRpbwoKM3JkIC0gcnVu
IG9uIHVzZXIgZW52OgpwdWxzZWF1ZGlvIC12dnYgCgpsZXRzIHRlc3Qgd2l0aCBrbWl4IEkgc2Vl
IG9uIHB1bHNlYXVkaW8gbG9ncyBhdCBtYXhpbXVtIDogCgpEOiBhbHNhLXNpbmsuYzogUmVxdWVz
dGVkIHZvbHVtZTogMDogMTAwJSAxOiAxMDAlCkQ6IGFsc2Etc2luay5jOiBHb3QgaGFyZHdhcmUg
dm9sdW1lOiAwOiAxMDAlIDE6IDEwMCUKRDogYWxzYS1zaW5rLmM6IENhbGN1bGF0ZWQgc29mdHdh
cmUgdm9sdW1lOiAwOiAxMDAlIDE6IDEwMCUKKGFjY3VyYXRlLWVub3VnaD15ZXMpCgp3aXRoIGdu
b21lLWNvbnRyb2wtY2VudGVyIC0+IHNvdW5kIEkgc2VlIG9uIHB1bHNlYXVkaW8gbG9ncyBhdApt
YXhpbXVtIDogCgpEOiBwcm90b2NvbC1uYXRpdmUuYzogQ2xpZW50IGdub21lLWNvbnRyb2wtY2Vu
dGVyIGNoYW5nZXMgdm9sdW1lIG9mIHNpbmsKYWxzYV9vdXRwdXQucGNpLTAwMDBfMDBfMWIuMC5h
bmFsb2ctc3RlcmVvLgpEOiBhbHNhLXNpbmsuYzogUmVxdWVzdGVkIHZvbHVtZTogMDogMTUzJSAx
OiAxNTMlCkQ6IGFsc2Etc2luay5jOiBHb3QgaGFyZHdhcmUgdm9sdW1lOiAwOiAxMDAlIDE6IDEw
MCUKRDogYWxzYS1zaW5rLmM6IENhbGN1bGF0ZWQgc29mdHdhcmUgdm9sdW1lOiAwOiAxNTMlIDE6
IDE1MyUKKGFjY3VyYXRlLWVub3VnaD1ubykKCnNvIGhvdyBJIHB1dCBrbWl4IGFsc28gY29udHJv
bCAic29mdHdhcmUgdm9sdW1lIiBzaW5jZSBzeXN0ZW0gdXNlIHB1bHNlLWF1ZGlvID8gCgpJIHJl
YWQgdGhpcyBhcnRpY2xlcyAKaHR0cDovL3d3dy53ZWJ1cGQ4Lm9yZy8yMDA5LzA4L2luY3JlYXNl
LW1heGltdW0tc291bmQtbGV2ZWwtaW4tdWJ1bnR1Lmh0bWwKaHR0cDovL2Fsc2Eub3BlbnNyYy5v
cmcvSG93X3RvX3VzZV9zb2Z0dm9sX3RvX2NvbnRyb2xfdGhlX21hc3Rlcl92b2x1bWUKCmJ1dCBj
YW4ndCBmaWd1cmUgb3V0LiAKCnRoYW5rcywKLS0gClPDqXJnaW8gTS4gQi4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpUaGlzIG1lc3NhZ2UgaXMg
ZnJvbSB0aGUga2RlIG1haWxpbmcgbGlzdC4KQWNjb3VudCBtYW5hZ2VtZW50OiAgaHR0cHM6Ly9t
YWlsLmtkZS5vcmcvbWFpbG1hbi9saXN0aW5mby9rZGUuCkFyY2hpdmVzOiBodHRwOi8vbGlzdHMu
a2RlLm9yZy8uCk1vcmUgaW5mbzogaHR0cDovL3d3dy5rZGUub3JnL2ZhcS5odG1sLgoKLS0gClPD
qXJnaW8gTS4gQi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZl
bAo=
