From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: RE: ymfpci : four speakers with OSS-emulation ?
Date: Wed, 13 Mar 2002 13:45:56 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NGBBLNODKDFPBFMBBFAFMEKLCDAA.James@superbug.demon.co.uk>
References: <3C7EF02B002549D4@mail.libertysurf.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Received: from anchor-post-36.mail.demon.net (anchor-post-36.mail.demon.net [194.217.242.94])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA06764
	for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2002 14:45:07 +0100
In-Reply-To: <3C7EF02B002549D4@mail.libertysurf.net> (added by postmaster@libertysurf.fr)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Xavier ALLAMIGEON <xavier.allamigeon@libertysurf.fr>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Why not just change the app to support alsa 0.9.x.
alsa 0.9.x is now in kernel 2.5.x, so the app should really move to
supporting it anyway.
Cheers
James


> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Xavier
> ALLAMIGEON
> Sent: 12 March 2002 21:11
> To: alsa-devel@alsa-project.org
> Subject: [Alsa-devel] ymfpci : four speakers with OSS-emulation ?
>
>
> 	Good evening,
> I have installed the alsa-driver0.9.0beta12 on my MDK8.1 (kernel
> 2.4.18), and
> my rear speakers work. For example with "aplay -Dhw:0,2 foo.wav".
> Is this possible to use the four speakers together under alsa or
> under the
> OSS emulation, with a sound card based on the ymfpci modules ?
> I know it works with a SBLive!. Besides, I have seen that there are
> interesting configuration files in /usr/share/alsa. What must I
> do if I want
> the changes of these files to take effect ?
> Thanks for all !
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
