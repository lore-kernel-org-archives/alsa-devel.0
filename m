From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ARM: tegra: Add to struct
	harmony_audio_platform_data
Date: Tue, 1 Feb 2011 14:17:35 +0000
Message-ID: <20110201141734.GJ12743@opensource.wolfsonmicro.com>
References: <1296513435-14792-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1DC0110392A
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 15:17:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296513435-14792-1-git-send-email-swarren@nvidia.com>
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

On Mon, Jan 31, 2011 at 03:37:15PM -0700, Stephen Warren wrote:
> Add fields to describe all the audio-related GPIOs on Harmony, except for
> the codec's GPIO IRQ, which will be passed in its i2c_board_info.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied, thanks.
