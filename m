From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core: Add DOUBLE_R variants of the
	_RANGE controls
Date: Fri, 22 Jun 2012 19:56:29 +0100
Message-ID: <1340391389.12316.2.camel@odin>
References: <1340361682-12409-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog127.obsmtp.com (na3sys009aog127.obsmtp.com
	[74.125.149.107])
	by alsa0.perex.cz (Postfix) with ESMTP id 8815210451B
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2012 20:56:36 +0200 (CEST)
Received: by wibhm11 with SMTP id hm11so679358wib.12
	for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2012 11:56:34 -0700 (PDT)
In-Reply-To: <1340361682-12409-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-06-22 at 11:41 +0100, Mark Brown wrote:
> The code handles this fine already, we just need new macros in the header
> for drivers to create the controls.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
