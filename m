From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: buffer producer/consumer sync
Date: Wed, 31 Mar 2004 11:22:56 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403311118140.1950@pnote.perex-int.cz>
References: <F509E6111989D311B63700805FA761DA0D82DE6E@DBDE01>
 <20040331083114.C27804@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403310936170.1950@pnote.perex-int.cz>
 <20040331085330.A30701@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403311004040.1950@pnote.perex-int.cz>
 <20040331091124.B30701@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403311027290.1950@pnote.perex-int.cz>
 <20040331095306.A32258@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403311100510.1950@pnote.perex-int.cz>
 <20040331101018.B32258@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040331101018.B32258@flint.arm.linux.org.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Russell King <rmk+alsa@arm.linux.org.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 31 Mar 2004, Russell King wrote:

> I suggest we add a load of preprocessor junk into the ALSA core and
> comment exactly _why_ its needed, thereby laying the reason completely
> at the door of these ill-defined APIs where questions have been asked
> and responses not been received.

I'm thinking to prepare more or less complete patch for all 
architectures and send it to LKML for a discussion.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
