From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] alsa-lib: Don't call the simple mixer
 interface "legacy"
Date: Sun, 31 Aug 2008 15:48:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0808311547360.23810@tm8103-a.perex-int.cz>
References: <20080831014256.GA21253@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DF8C1244F5
	for <alsa-devel@alsa-project.org>;
	Sun, 31 Aug 2008 15:48:22 +0200 (CEST)
In-Reply-To: <20080831014256.GA21253@omega>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 31 Aug 2008, Lennart Poettering wrote:

> The simpler mixer interface is not legacy, so the header file shouldn't 
> claim otherwise.
> 
> Fixes bug 3569

Thanks for patches. All three are in ALSA's alsa-lib git repo now.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
