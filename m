From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: multi-component: SAMSUNG:
	Fix	compile error when registering a DAI
Date: Thu, 22 Jul 2010 11:56:39 +0100
Message-ID: <20100722105638.GK10930@sirena.org.uk>
References: <4C47D3A3.9000102@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 86769103992
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 12:56:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C47D3A3.9000102@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 22, 2010 at 02:14:11PM +0900, Chanwoo Choi wrote:
> This patch modify some code which register a DAI with ASoC core
> according to modified registration API of DAI.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
