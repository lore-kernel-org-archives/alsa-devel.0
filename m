From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Support for Midiman M-Audio Delta 410
Date: Mon, 4 Nov 2002 10:02:00 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211041000370.505-100000@pnote.perex-int.cz>
References: <1036392346.3dc6179a31cd2@albert.homedns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1036392346.3dc6179a31cd2@albert.homedns.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kristof Pelckmans <Kristof.Pelckmans@antwerpen.be>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "ajh@watri.uwa.edu.au" <ajh@watri.uwa.edu.au>
List-Id: alsa-devel@alsa-project.org

On Mon, 4 Nov 2002, Kristof Pelckmans wrote:

> > > Could I try it the old-fashioned way : simple try-and-error starting from
> > the 
> > > Audiophile configuration ?
> > 
> > Yes, you can. Simply, try to modify the alsa-kernel/ice1712/delta.c code. 
> > Perhaps, Takashi might commit the AK4529 support to have more fun...
> > 
> I tried this over the weekend, but keeped getting core dumps. Next weekend, I 
> will have the opportunity to give the exact GPIOs. Still upset that M-Audio 
> writes that the card _is_ supported under Linux, while apparently getting the 
> necessary info isn't all that easy...

Where is this stated? If M-Audio says that their newer hardware is
supported, I'll try to push my contacts at M-Audio to release
specification for newer products (like 410).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
