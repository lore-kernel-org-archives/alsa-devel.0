From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: pxa: Convert corgi to use
 snd_soc_register_card()
Date: Mon, 2 Jan 2012 12:48:40 +0000
Message-ID: <20120102124840.GH4300@opensource.wolfsonmicro.com>
References: <1325214804.2569.3.camel@phoenix> <1325215093.2569.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9A8661038FA
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2012 13:48:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325215093.2569.8.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Eric Miao <eric.y.miao@gmail.com>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 30, 2011 at 11:18:13AM +0800, Axel Lin wrote:
> Use snd_soc_register_card() instead of creating a "soc-audio" platform device.

Applied, thanks.
