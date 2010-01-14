From: "Maher Fahmi" <maher@teradici.com>
Subject: Re: hda_intel.c patch requested for Teradici
Date: Thu, 14 Jan 2010 13:58:56 -0800
Message-ID: <71C39AE3DF382B4A9CD370AD1C63B85501FB1D1C@stervanexmb01.teradici.local>
References: <71C39AE3DF382B4A9CD370AD1C63B85501FB1BC9@stervanexmb01.teradici.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA9564.C499F6AA"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.teradici.com (smtp.teradici.com [216.18.71.1])
	by alsa0.perex.cz (Postfix) with ESMTP id BD06F1037E3
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 22:59:03 +0100 (CET)
Content-class: urn:content-classes:message
In-Reply-To: <71C39AE3DF382B4A9CD370AD1C63B85501FB1BC9@stervanexmb01.teradici.local>
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA9564.C499F6AA
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

ALSA Team,

Sorry to bother you with this again.  I haven't yet received
confirmation (or rejection) from the moderator, and just wondering if
there's anything else I can/should do.

=20

Best regards & Happy New Year,

Maher.

=20

________________________________

From: Maher Fahmi=20
Sent: Friday, December 04, 2009 1:41 PM
To: 'alsa-devel@alsa-project.org'
Subject: hda_intel.c patch requested for Teradici

=20

Alsa Team,

Enclosed is a patch to the hda_intel.c file from the alsa-driver-1.0.21
package.  I tried to submit this using git, but ran into some problems
that exceed my limited understanding of Linux.  I hope this will suffice
for you.

=20

Summary: Fix to a HW issue in which the 64OK register bit of the GCAP
register is incorrectly asserted.

=20

Signed-off-by: Maher Fahmi mfahmi@teradici.com

=20

Thanks very much,

Maher.


------_=_NextPart_001_01CA9564.C499F6AA
Content-Type: application/octet-stream;
	name="hda_intel.c.patch"
Content-Transfer-Encoding: base64
Content-Description: hda_intel.c.patch
Content-Disposition: attachment;
	filename="hda_intel.c.patch"

aXdha2l7bWZhaG1pfSBkaWZmIC11IGhkYV9pbnRlbC5jLnRlcmFkaWNpIH4vYWxzYV9kcml2ZXIv
YWxzYS1kcml2ZXItMS4wLjIxL2Fsc2EtZHJpdmVyLTEuMC4yMS9hbHNhLWtlcm5lbC9wY2kvaGRh
L2hkYV9pbnRlbC5jDQotLS0gaGRhX2ludGVsLmMudGVyYWRpY2kgICAgICAgIDIwMDktMTAtMjkg
MTY6MjE6MzYuMDgzMTQ4MDAwIC0wNzAwDQorKysgL2hvbWUvbWZhaG1pL2Fsc2FfZHJpdmVyL2Fs
c2EtZHJpdmVyLTEuMC4yMS9hbHNhLWRyaXZlci0xLjAuMjEvYWxzYS1rZXJuZWwvcGNpL2hkYS9o
ZGFfaW50ZWwuYyAgICAgIDIwMDktMDgtMjggMDQ6NDE6NDAuMDAwMDAwMDAwIC0wNzAwDQpAQCAt
NTE1LDcgKzUxNSw2IEBADQogICAgICAgICAgICAgICAgc25kX3ByaW50ayhLRVJOX0VSUiBTRlgg
ImNhbm5vdCBhbGxvY2F0ZSBDT1JCL1JJUkJcbiIpOw0KICAgICAgICAgICAgICAgIHJldHVybiBl
cnI7DQogICAgICAgIH0NCi0NCiAgICAgICAgcmV0dXJuIDA7DQogfQ0KDQpAQCAtMjQxOCwxMiAr
MjQxNyw2IEBADQogICAgICAgIGdjYXAgPSBhenhfcmVhZHcoY2hpcCwgR0NBUCk7DQogICAgICAg
IHNuZF9wcmludGRkKFNGWCAiY2hpcHNldCBnbG9iYWwgY2FwYWJpbGl0aWVzID0gMHgleFxuIiwg
Z2NhcCk7DQoNCi0gICAgICAgIC8qZGlzYWJsZSBUZXJhZGljaSA2NGJpdCBzdXBwb3J0IC0gY2Jh
cm9uIDEwLzI5LzA5Ki8NCi0gICAgICAgaWYgKGNoaXAtPmRyaXZlcl90eXBlID09IEFaWF9EUklW
RVJfVEVSQSkgew0KLSAgICAgICAgICAgICAgIGdjYXAgPSBnY2FwICYgMHhGRkZFOw0KLSAgICAg
ICAgfQ0KLQ0KLQ0KICAgICAgICAvKiBkaXNhYmxlIFNCNjAwIDY0Yml0IHN1cHBvcnQgZm9yIHNh
ZmV0eSAqLw0KICAgICAgICBpZiAoKGNoaXAtPmRyaXZlcl90eXBlID09IEFaWF9EUklWRVJfQVRJ
KSB8fA0KICAgICAgICAgICAgKGNoaXAtPmRyaXZlcl90eXBlID09IEFaWF9EUklWRVJfQVRJSERN
SSkpIHsNCg==

------_=_NextPart_001_01CA9564.C499F6AA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------_=_NextPart_001_01CA9564.C499F6AA--
