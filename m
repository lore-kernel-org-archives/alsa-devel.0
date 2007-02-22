From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Fix for SPAM?
Date: Thu, 22 Feb 2007 08:39:41 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0702220827300.9439@tm8103-a.perex-int.cz>
References: <s5hmz39rt2y.wl%tiwai@suse.de> <45DB44F9.9080001@gmail.com>
	<1172043403.17395.1175709503@webmail.messagingengine.com>
	<45DC5B1A.5090100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45DC5B1A.5090100@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Rene Herman <rene.herman@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Feb 2007, Rene Herman wrote:

> On 02/21/2007 08:36 AM, Clemens Ladisch wrote:
> 
> > Most of the spam comes through the old list server alsa-project.org. It
> > would be enough to disable non-subscriber postings there, or to
> > kill it entirely.
> 
> If I'm not mistaken, this was remarked 53 times of the previous 67 times this
> alsa-devel spam issue came up as well, thereby seemingly causing the
> discussion to peter out without anything actually having been done.
> 
> Jaroslav: should the list be moved to vger, assuming they wouldn't mind
> hosting it?

It's not a problem for me to move lists (I would prefer to let people 
resubscribe to filter the "dead" subscribers).

But, I would like really to keep the universal e-mail address like 
alsa-devel@alsa-project.org rather than alsa-devel@vger or 
alsa-devel@sourceforge....). Actually, the old ALSA server cannot be 
configured to filter e-mails using spam-assassin (the hardware simply 
cannot handle it) and SF appearently uses sender verification (it does not 
accept e-mails from hosts not having SMTP server installed and with broken 
SMTP HELO hostnames).

For immediate solution, I would suggest to moderate list (but I haven't 
time to do it) so I'm asking here for an volunteer (or volunteers). I will 
send them the list administration password on SourceForge.

If everything happens well, I will switch the ALSA server to a XEN virtual 
server with Spam-Assassin in few weeks. So the possibility to filter out 
spams will be greatly increased.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
