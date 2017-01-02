From: =?UTF-8?Q?Giedrius_Trainavi=C4=8Dius?= <giedrius.trainavicius@gmail.com>
Subject: Re: Stream format conversion in SoC driver
Date: Mon, 2 Jan 2017 21:59:19 +0200
Message-ID: <CABpuRUOVAr6nxLvdEM9oKjsW1a8Kyhdqdq_OdS-7cHR8NLtQaw@mail.gmail.com>
References: <CABpuRUPg8LC_+eFL3UBS-jWkQicpKmorvzhqjZW6p8xQ9P0ppw@mail.gmail.com>
 <089A4555-3272-4E65-8AD6-412B41017ACA@ladisch.de>
 <CABpuRUMfB+VvwpqMz7mc_q1RCYR5RS-FjQ8czVXUYeW70y_V7A@mail.gmail.com>
 <88898566-E09E-49FF-99D7-5EC03120FB87@ladisch.de>
 <CABpuRUM-n9b0NTivk-2zBsuvL5O-f9PXLeQoc6wW=YhrxndABQ@mail.gmail.com>
 <C1F64983-FEE0-4CA8-A623-9315B4D155EF@ladisch.de>
 <CABpuRUM-SHzVrGuoyWKicQdhmDgOFEa0NH6CiAiXFum16BtN2A@mail.gmail.com>
 <16CD146D-B2B1-420B-8680-3A6FCD0B4BA6@ladisch.de>
 <CABpuRUOppLmT+KFSPJOaxo6EtaoTeM9UnHBOVwkn=DbwN0MPDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f66.google.com (mail-vk0-f66.google.com
 [209.85.213.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 6518F26058A
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2017 20:59:21 +0100 (CET)
Received: by mail-vk0-f66.google.com with SMTP id 19so14082288vko.3
 for <alsa-devel@alsa-project.org>; Mon, 02 Jan 2017 11:59:21 -0800 (PST)
In-Reply-To: <CABpuRUOppLmT+KFSPJOaxo6EtaoTeM9UnHBOVwkn=DbwN0MPDg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGV5LAoKQW55IHRob3VnaHRzIG9yIHBvaW50ZXJzIG9uIHdoYXQgdG8gbG9vayBmb3IgaW4gb3Jk
ZXIgdG8gdXNlIGRpZmZlcmVudApzYW1wbGUgZm9ybWF0IGJldHdlZW4gYWN0dWFsIEkyUyBhbmQg
RE1BPwoKVGhhbmsgeW91LApHaWVkcml1cy4KCk9uIFRodSwgRGVjIDI5LCAyMDE2IGF0IDQ6MzIg
UE0sIEdpZWRyaXVzIFRyYWluYXZpxI1pdXMgPApnaWVkcml1cy50cmFpbmF2aWNpdXNAZ21haWwu
Y29tPiB3cm90ZToKCj4gVGhlIEkyUyBhbmQgRE1BIGZvcm1hdCBhc3ltbWV0cnkgc291bmRzIGxp
a2Ugd2hhdCBJJ2QgYmUgYWZ0ZXIuIERvIHlvdQo+IGhhdmUgYW55IHBvaW50ZXJzIGZvciBBUElz
IC8ga2V5d29yZHMgdG8gbG9vayBhcm91bmQgZm9yIGluIHRoZSBjb2RlIHRvIHNlZQo+IGhvdyB0
aGlzIHNob3VsZCBiZSBzZXQgdXA/IElzIHN1Y2ggZm9ybWF0IGNvbnZlcnNpb24gc3VwcG9zZWQg
dG8gYmUKPiBoYXBwZW5pbmcgaW4gaGFyZHdhcmUgaXRzZWxmLCBvciB0aGUgQ1BVIHdoZW4gYWNj
ZXNzaW5nIHRoZSBETUEgYnVmZmVyIGhhcwo+IHRoZSBjaGFuY2UgdG8gZG8gdGhlIGNvbnZlcnNp
b24/Cj4KPiBUaGUgcmVsZXZhbnQgZG9jdW1lbnRhdGlvbiBhbmQgY29kZSBJIGZvdW5kIHNvIGZh
ciB3b3VsZCBiZToKPgo+IGh0dHBzOi8vd3d3LnJhc3BiZXJyeXBpLm9yZy9kb2N1bWVudGF0aW9u
L2hhcmR3YXJlL3Jhc3BiZXJyeQo+IHBpL2JjbTI4MzUvQkNNMjgzNS1BUk0tUGVyaXBoZXJhbHMu
cGRmCj4gaHR0cHM6Ly9naXRodWIuY29tL3Jhc3BiZXJyeXBpL2xpbnV4L2Jsb2IvcnBpLTQuNC55
L3NvdW5kLwo+IHNvYy9iY20vYmNtMjgzNS1pMnMuYwo+Cj4gSSBjYW4ndCBsb2NhdGUgYW55IHJl
bGV2YW50IGJpdHMgb2YgY29kZSBvciBpbmZvcm1hdGlvbiB0aGF0J2QgaW5kaWNhdGUKPiBjYXBh
YmlsaXRpZXMgb2Ygc2FtcGxlIGZvcm1hdCBjb252ZXJzaW9uLi4uCj4KPiBUaGFuayB5b3UsCj4g
R2llZHJpdXMuCj4KPiBPbiBUaHUsIERlYyAyOSwgMjAxNiBhdCA3OjUzIEFNLCBDbGVtZW5zIExh
ZGlzY2ggPGNsZW1lbnNAbGFkaXNjaC5kZT4KPiB3cm90ZToKPgo+PiBHaWVkcml1cyBUcmFpbmF2
acSNaXVzIHdyb3RlOgo+PiA+SXQgdXNlcyBJMlMgZm9yIHNlbmRpbmcgLyByZWNlaXZpbmcgYXVk
aW8uIEhvd2V2ZXIsIHRoZSBtYXN0ZXIgY2xvY2sgb24KPj4gb3VyCj4+ID5zb3VuZCBjYXJkIGlz
IGdlbmVyYXRlZCBieSB0aGUgQURDLCB3aGljaCBzdXBwb3J0cyBvbmx5IDI0IGJpdCBkYXRhLCBz
bwo+PiA+Z2V0dGluZyBvdGhlciBzYW1wbGUgZm9ybWF0cyBpcyBub3QgcG9zc2libGUuCj4+Cj4+
IFRoZSBJMlMgc2FtcGxlIGZvcm1hdCBuZWVkIG5vdCBiZSB0aGUgc2FtZSBhcyB3aGF0IHRoZSBE
TUEKPj4gY29udHJvbGxlciByZWFkcy93cml0ZXMgZnJvbS90byBtZW1vcnkuCj4+Cj4+ID5BIHF1
ZXN0aW9uIG9uICdwbHVnJyAtIGl0IGFjY2VwdHMgJ25lYXJlc3QnIGFzIHRoZSBhcmd1bWVudCBm
b3IgZm9ybWF0LAo+PiA+cmF0ZSwgd2hhdCBoYXBwZW5zIGluIGNhc2UgdGhlIHNsYXZlIHBjbSBz
dHJlYW0gc3VwcG9ydHMgdGhlIGV4YWN0IHNhbWUKPj4gPmZvcm1hdCBhcyByZXF1ZXN0ZWQgYnkg
dXNlciBzb2Z0d2FyZT8KPj4KPj4gVGhlIHBsdWcgcGx1Z2luIGluc3RhbnRpYXRlcyB0aGUgYWN0
dWFsIGNvbnZlcnNpb24gcGx1Z2lucyBvbmx5Cj4+IGFzIG5lZWRlZDsgd2l0aCBubyBjb252ZXJz
aW9uLCBpdCB2YW5pc2hlcyBlbnRpcmVseS4KPj4KPj4KPj4gUmVnYXJkcywKPj4gQ2xlbWVucwo+
Pgo+Pgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
