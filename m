From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: A bug or feature in PCM handling or is it really meant to be this way?
Date: Mon, 25 Aug 2003 14:49:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308251449.05449.adrian@mcmen.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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

I have been working on writing an ALSA driver for the Sega Dreamcast AICA=
=20
sound system (PCM). But I have noticed that 2.6.0-test2 will not build fo=
r=20
PCM unless the OSS PCM emulation is turned on?

Is that the way it is meant to be? If so, why different options in the kb=
uild=20
process?

Adrian


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
