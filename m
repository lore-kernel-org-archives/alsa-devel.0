From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: aplay -l messes up terminal settings.
Date: Wed, 18 Aug 2010 08:30:55 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008180830310.10278@eeebox2.perex-int.cz>
References: <4C6B3BD7.2070206@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id CF9A6243A4
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 08:30:55 +0200 (CEST)
In-Reply-To: <4C6B3BD7.2070206@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 18 Aug 2010, Eliot Blennerhassett wrote:

> Hi Jaroslav,
>
> there is something wrong with the last commit to aplay (at least for me
> Gnome terminal 2.29.6).
>
> When I do aplay -l or aplay -L,  my keystrokes are subsequently not
> echoed in the terminal.

Sorry. I fixed this issue in git now.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
