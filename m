From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/5] ASoC: Get the card directly from the
	DAPM context
Date: Thu, 03 Mar 2011 10:34:15 +0000
Message-ID: <1299148455.3337.5.camel@odin>
References: <1299093671-12309-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 81F692444C
	for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2011 11:34:19 +0100 (CET)
Received: by wyb28 with SMTP id 28so874809wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Mar 2011 02:34:19 -0800 (PST)
In-Reply-To: <1299093671-12309-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-03-02 at 19:21 +0000, Mark Brown wrote:
> Rather than indirecting through the CODEC we can look the card up directly
> from the card pointer in the DAPM context.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
