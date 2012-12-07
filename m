From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-twl4030: Update the header file
 to support more boards
Date: Fri, 7 Dec 2012 12:54:45 +0900
Message-ID: <20121207035440.GD26070@opensource.wolfsonmicro.com>
References: <1354804525-5330-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C71F02616E0
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2012 04:54:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1354804525-5330-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 06, 2012 at 03:35:25PM +0100, Peter Ujfalusi wrote:
> The common machine driver will be able to support new boards where the voice
> port is also in use.
> At the same time add possibility to fine tune the connections from twl4030
> on the board: jack detection GPIO, input/output selection

Applied, thanks.
