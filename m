From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: HG -> GIT migration
Date: Wed, 21 May 2008 14:30:31 +0200
Message-ID: <483415E7.5080402@keyaccess.nl>
References: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz>	<200805211430.06653.linux@audioscience.com>	<Pine.LNX.4.61.0805210805080.1798@tm8103-a.perex-int.cz>
	<s5hve18vtml.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id AA23424545
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 14:28:03 +0200 (CEST)
In-Reply-To: <s5hve18vtml.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 21-05-08 12:28, Takashi Iwai wrote:

> Anyway, I'll apply patches including major changes of kconfig parser
> soon later (after some issues with shared git repo are resolved).
> Then we'll revise the problem again.

By the way, I've been pulling in the "latest alsa" repo you recently 
provided an URL for:

$ git remote show sound-2.6
* remote sound-2.6
   URL: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
   Tracked remote branches
     master

What's the status of that one now? Should I continue pulling that one or 
should I switch to the new alsa-kernel GIT repo? I want to pull it into 
a Linus clone tree...

Rene.
