From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH]snd-usb-usx2y
Date: Thu, 27 Nov 2003 15:59:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311271559.13764.annabellesgarden@yahoo.de>
References: <200311271544.21367.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200311271544.21367.annabellesgarden@yahoo.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 27. November 2003 15:44 schrieb Karsten Wiese:
> Hi,
>
> this fixes an us428 error that crept in during us122 merge.
> Please commit with comment:
> - Start devices audio-engine on driver startup.
should be:
- Start device's audio-engine on driver startup.
> - Prepare for us224 - Tests.
>
> Thanks,
> Karsten



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
