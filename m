From: Claus Ilginnis <Claus@Ilginnis.de>
Subject: Detect when sound card is in use
Date: Tue, 28 Apr 2009 21:16:26 +0200
Message-ID: <1240946186.6657.8.camel@trex>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 90FED24559
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 21:16:27 +0200 (CEST)
Received: from andrea.warrior
	(stgt-5f70026d.pool.einsundeins.de [95.112.2.109])
	by post.strato.de (mrclete mo19) (RZmta 18.31)
	with AES128-SHA encrypted ESMTP id C064dal3SHhoCu
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 21:16:26 +0200 (MEST)
Received: from [192.168.1.27] by andrea.warrior with esmtp (Exim 4.69)
	(envelope-from <Claus@Ilginnis.de>) id 1Lysn4-0001PK-CT
	for alsa-devel@alsa-project.org; Tue, 28 Apr 2009 21:16:26 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

CkhpIGV2ZXJ5b25lLAoKSSBoYXZlIGEgcHJvYmxlbSBhbmQgSSBkb250J3Qga25vdyB3aGVyZSB0
byBhc2sgbXkgcXVlc3Rpb25zIGFueW1vcmUsIHNvCkkgaG9wZSB0aGlzIG1haWxpbmcgbGlzdCBj
YW4gaGVscCBtZSBtYWtlIHByb2dyZXNzIHdpdGggbXkgcHJvYmxlbS4uLi4KCkkgaGF2ZSBhIHNw
ZWFrZXIgc2V0IGNvbm5lY3RlZCB0byBhbiBVU0ItUG93ZXItUGx1ZyAoYnkgd2hpY2ggSSBjYW4g
dHVybgp0aGUgc3BlYWtlcnMgb24gYW5kIG9mZiApCgpOb3cgSSB3YW50IHRvIGRldGVjdCwgd2hl
biB0aGUgc291bmRjYXJkIGlzIGluIHVzZSBhbmQgd2hlbiBub3QuCih0byB0dXJuIHRoZSBzcGVh
a2VycyBvbiB3aGVuIG5lZWRlZC4uLikKKEkgYW0gYSBDKysgcHJvZ3JhbW1lciBzbyBJIGNhbiBt
ZXNzIHNvbWUgdGhpbmdzIHVwKQoKU28gbXkgcXVlc3Rpb24gaXM6CldoaWNoIHdheSBpcyBiZXN0
IHRvIGRldGVjdCB3aGVhdGhlciBteSBzb3VuZCBjYXJkIGlzIGluIHVzZSBvciBub3QgPwpJcyB0
aGVyZSBhIGdlbmVyYWwgb3ZlcnZpZXcvZG9jdW1lbnRhdGlvbiBvZiB0aGUgc291bmQga2VybmVs
IG1vZHVsZXMKd2hpY2ggZGVzY3JpYmVzIHRoZSBnZW5lcmFsIHJlbGF0aW9uc2hpcCBiZXR3ZWVu
IHRoZW0gPwpXaGF0IHdvdWxkIHlvdSBkbyA/CgpQTEVBU0UgaGVscCAhCgoKLSAgCgpNaXQgZnJl
dW5kbGljaGVuIEdyw7zDn2VuIC8gQmVzdCByZWdhcmRzCkNsYXVzIElsZ2lubmlzCgoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
