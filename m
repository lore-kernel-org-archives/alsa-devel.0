From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Error when trying to compile code from CVS
Date: Tue, 27 Sep 2005 08:48:18 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509270845040.6513-100000@studcom.urz.uni-halle.de>
References: <20050926174031.GA7590@martinkl.dialup.fu-berlin.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050926174031.GA7590@martinkl.dialup.fu-berlin.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Klaiber <martinkl@zedat.fu-berlin.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Martin Klaiber wrote:
> when I try to compile the actual code from the CVS, I get the
> following error:
>
>    In file included from memory.c:2:
>    ../alsa-kernel/core/memory.c:126: error: syntax error before "this_object_must_be_defined_as_export_objs_in_the_Makefile"

Which kernel version are you running?  Which kernel version are you
compiling for?  What is the output of the configure script?


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
