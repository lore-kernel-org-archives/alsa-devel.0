From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: hw_params and approximate values
Date: Thu, 21 Aug 2003 19:11:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprt9l1hv6q1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

I'm not sure if I quite understand the alsa-lib docs regarding the=20
snd_pcm_hw_params API; in addition to an approximate integer value, one=20
might specify a direction. Is the direction parameter a way to instruct=20
ALSA to look for a floating point value in either direction? If that's th=
e=20
case, couldn't this be handled with floats directly?

Regards

Arve Knudsen


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
