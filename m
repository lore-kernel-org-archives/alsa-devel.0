From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/5] ASoC: ad193x: fix dac word len
	setting
Date: Mon, 15 Aug 2011 22:29:53 +0900
Message-ID: <20110815132950.GI3927@opensource.wolfsonmicro.com>
References: <1313186654-22520-1-git-send-email-scott.jiang.linux@gmail.com>
	<1313186654-22520-2-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 50AE124630
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 15:30:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313186654-22520-2-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 12, 2011 at 06:04:11PM -0400, Scott Jiang wrote:
> dac word len value should left shift before setting
> 
> Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>

Applied, thanks.
