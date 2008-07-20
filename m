From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: GIT: something wrong with sound-2.6/devel?
Date: Sun, 20 Jul 2008 21:08:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0807202104390.7676@tm8103-a.perex-int.cz>
References: <48838A54.40404@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A99410382A
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jul 2008 21:09:03 +0200 (CEST)
In-Reply-To: <48838A54.40404@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 20 Jul 2008, Rene Herman wrote:

> Hi Takashi.
> 
> Is there something wrong with your devel branch or is it me?

I think that you have to recommit your patches on top of new Takashi's 
tree, because Takashi rebased his tree on top of Linus's tree.

Anyway, I just synced git.alsa-project.org to Linus's and Takashi's trees 
a few minutes ago, too.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
