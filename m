From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: Samsung: Debug PCM
 snd_soc_dai_driver registration
Date: Tue, 14 Sep 2010 08:50:39 +0100
Message-ID: <20100914075038.GA423@opensource.wolfsonmicro.com>
References: <1284104465-17287-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 094DE243AF
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Sep 2010 09:50:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284104465-17287-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, Jassi Brar <jassi.brar@samsung.com>, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 10, 2010 at 04:41:05PM +0900, Jassi Brar wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> Each of the two PCM controllers need to be registered during probe
> with appropriate 'name' of the dai driver.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

Applied, thanks.
