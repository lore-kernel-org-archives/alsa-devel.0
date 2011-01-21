From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 1/4] ASoC: WM8903: Expose GPIOs through
	gpiolib
Date: Fri, 21 Jan 2011 12:05:29 +0000
Message-ID: <20110121120529.GC8186@opensource.wolfsonmicro.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295556731-25165-2-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4E349245CC
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 13:05:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295556731-25165-2-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 20, 2011 at 01:52:08PM -0700, Stephen Warren wrote:
> Also, fix platform_data GPIO handling to have an explicit "don't touch this
> pin" option.
> 
> Add #defines for the GPIO pin functions.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied this one, thanks.
