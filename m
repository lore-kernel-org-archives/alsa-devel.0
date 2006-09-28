From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [alsa-cvslog] ROLLBACK! alsa-kernel: hda-intel -
 New pci id for Nvidia MCP61
Date: Thu, 28 Sep 2006 12:46:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0609281235400.9381@tm8103.perex-int.cz>
References: <ALOGGER1159439233.06@alsa-project.org>
	<m2wt7ol1r5.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <m2wt7ol1r5.fsf@vador.mandriva.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Sep 2006, Thierry Vignaud wrote:

> root@perex.cz writes:
> 
> //\\ 
> humm...
> 
> > changeset:   4551:7cc57ec28195798dcf45c0125ea8991e00ec845d
> > tag:         tip
> > user:        tiwai
> > date:        Tue Sep 26 15:32:35 2006 +0200
> > files:       pci/hda/hda_intel.c
> > description:
> > hda-intel - New pci id for Nvidia MCP61
> > 
> > Added the new PCI id to support Nvidia MCP61 in snd-hda-intel driver.
> > 
> > Signed-off-by: Dan Cyr <rabidfly@hotmail.com>
> 
> why isn't there any diff inline like for other commits?

Sorry, it was not clear what 'ROLLBACK' in the subject means.

I've put this comment to rollback e-mails:

=====
The rollback was triggered. The repository was rolled back to
the changeset number bellow. All patches on top of this changeset
were lost.
=====

So, you already received patch #4551.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
