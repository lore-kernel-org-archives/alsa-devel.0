From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: v1.0.14 - test packages #2
Date: Mon, 4 Jun 2007 12:05:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0706041205000.7767@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0706040930220.7767@tm8103.perex-int.cz>
	<200706041151.10173.mgd@technosis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E9F924548
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2007 12:05:32 +0200 (CEST)
In-Reply-To: <200706041151.10173.mgd@technosis.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Gerdau <mgd@technosis.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 4 Jun 2007, Michael Gerdau wrote:

> Hi Jaroslav,
> 
> > 	I recreated driver and tools packages in /pub/testing to fix
> > reported problems. Please, test...
> 
> configure still fails for me in subdir qlo10k1 of alsa-tools-1.0.14.
> 
> I'm on openSUSE 10.2, x86_64. The problem most likely has to do with
> correctly finding the 64bit Qt libs.

Thanks. Could you try new alsa-tools package in /pub/testing ?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
