From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Wed, 18 Sep 2002 13:02:35 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020918120235.49273.qmail@web40601.mail.yahoo.com>
References: <Pine.LNX.4.33.0209181054350.534-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0209181054350.534-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

 --- Jaroslav Kysela <perex@perex.cz> wrote: > On Wed,
18 Sep 2002, Chris Rankin wrote:
> Note: If
> SND_COMPATIBILITY_BUILD_RC3 is defined, 
> then applications need to fall back to 0.9.0rc3 API
> as well.

So maybe we could have a --with-compat-rc3 option for
alsa-utils as well? Regardless of which alsa-lib I
build, I always need to be able to build alsa-utils.
And I doubt that wine and xine will get updated before
-rc4 is released. (Unless there's a document somewhere
explaining the relationship between the old and new
API functions, in which case I could submit patches
myself.)

Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
