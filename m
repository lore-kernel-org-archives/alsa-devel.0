From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: 1.0.6rc1 packages
Date: Wed, 4 Aug 2004 23:53:45 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32796.192.168.1.5.1091660025.squirrel@192.168.1.5>
References: <Pine.LNX.4.58.0408042050320.15189@pnote.perex-int.cz>   
    <41116082.20500@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.netcabo.pt (smtp.netcabo.pt [212.113.174.9])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C2D5220D
	for <alsa-devel@alsa-project.org>; Thu,  5 Aug 2004 00:56:01 +0200 (MEST)
In-Reply-To: <41116082.20500@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Martin Langer <martin-langer@gmx.de>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

>
> Hi all,
> 	the 1.0.6rc1 ALSA packages are available for testing.
>

Everything builds fine on my SUSE 9.1 box, for a 2.6.8-rc2 SMP/HT kernel.
That includes snd-usb-usx2y is compiling, loading and sounds fine.

Tomorrow I'll try on my dreaded laptop, Mdk10.0, 2.6.8-rc2 UP kernel,
where recent snd-usb-usx2y it's known to freeze the whole system :(

BTW, it's not a SMP vs. UP issue, as I've tested today on a SMP kernel
with a very same config as of my other box, and the freezing result was
the same.

Regards,
--=20
rncbc aka Rui Nuno Capela
rncbc@rncbc.org






-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
