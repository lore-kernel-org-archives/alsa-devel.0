From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ad193x: add set_sysclk entry to support
 different clock input
Date: Fri, 21 May 2010 10:26:59 +0100
Message-ID: <1274434019.3258.2.camel@odin>
References: <1274414221-12200-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E4A6103990
	for <alsa-devel@alsa-project.org>;
	Fri, 21 May 2010 11:27:05 +0200 (CEST)
Received: by wwe15 with SMTP id 15so482727wwe.38
	for <alsa-devel@alsa-project.org>; Fri, 21 May 2010 02:27:04 -0700 (PDT)
In-Reply-To: <1274414221-12200-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-05-21 at 11:57 +0800, Barry Song wrote:
> Signed-off-by: Barry Song <21cnbao@gmail.com>
> ---
>  sound/soc/codecs/ad193x.c |   41 ++++++++++++++++++++++++++++++++++++++++-
>  sound/soc/codecs/ad193x.h |    5 +++++
>  2 files changed, 45 insertions(+), 1 deletions(-)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
