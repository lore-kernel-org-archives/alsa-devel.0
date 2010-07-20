From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: multi-component - Enable
 WM8993/4 common code to support WM8994
Date: Tue, 20 Jul 2010 09:45:19 +0100
Message-ID: <20100720084518.GD10222@rakim.wolfsonmicro.main>
References: <4C453401.1060401@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2E1A41038C9
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 10:45:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C453401.1060401@samsung.com>
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
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 20, 2010 at 02:28:33PM +0900, Chanwoo Choi wrote:
> This patch enable WM8993/4 common code which is used in WM8994 driver.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

This should also be applied to mainline directly rather than
multi-component.
