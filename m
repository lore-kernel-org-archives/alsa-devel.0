From: Kristof Pelckmans <Kristof.Pelckmans@antwerpen.be>
Subject: Re: Support for Midiman M-Audio Delta 410
Date: Mon,  4 Nov 2002 07:45:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1036392346.3dc6179a31cd2@albert.homedns.org>
References: <Pine.LNX.4.33.0210312016570.5341-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0210312016570.5341-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "ajh@watri.uwa.edu.au" <ajh@watri.uwa.edu.au>
List-Id: alsa-devel@alsa-project.org

> > Could I try it the old-fashioned way : simple try-and-error starting from
> the 
> > Audiophile configuration ?
> 
> Yes, you can. Simply, try to modify the alsa-kernel/ice1712/delta.c code. 
> Perhaps, Takashi might commit the AK4529 support to have more fun...
> 
I tried this over the weekend, but keeped getting core dumps. Next weekend, I 
will have the opportunity to give the exact GPIOs. Still upset that M-Audio 
writes that the card _is_ supported under Linux, while apparently getting the 
necessary info isn't all that easy...

Ciaos

Kristof




-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
