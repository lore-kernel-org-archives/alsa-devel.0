From: Andy Lo-A-Foe <andy@alsaplayer.org>
Subject: Re: pkg-config (was Re: new "in-compatible" alsa-lib PCM API )
Date: Wed, 18 Sep 2002 19:49:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020918174914.GA4141@orbital.xs4all.nl>
References: <Pine.LNX.4.33.0209181416130.534-100000@pnote.perex-int.cz> <E17rfBE-0001EJ-00@usw-sf-list1.sourceforge.net> <s5hbs6vqm0w.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hbs6vqm0w.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <pbd@op.net>, Jaroslav Kysela <perex@perex.cz>, Chris Rankin <rankincj@yahoo.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 18, 2002 at 06:51:11PM +0200, Takashi Iwai wrote:

> one related question is - 
> is there any problem to keep alsa.m4 file?  or should it be removed
> and force people to move to pkg-config from AC macros?

Removing alsa.m4 is probably the best way to speed up adoption of
pkg-config based support, so IMHO it should go ASAP! ;-)

Andy


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
