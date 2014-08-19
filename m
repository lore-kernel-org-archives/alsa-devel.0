From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 2/2] mfd: arizona: Update DT binding
	to	support INn_MODE init_data
Date: Tue, 19 Aug 2014 12:41:16 +0100
Message-ID: <20140819114116.GF7556@opensource.wolfsonmicro.com>
References: <20140819201407.3447715e@songinha-Samsung-DeskTop-System>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6F52B2655F6
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 13:41:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140819201407.3447715e@songinha-Samsung-DeskTop-System>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Inha Song <ideal.song@samsung.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, sameo@linux.intel.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, broonie@kernel.org, galak@codeaurora.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 19, 2014 at 08:14:07PM +0900, Inha Song wrote:
> This patch update DT binding to support INn_MODE init_data. Each
> input signal path can be configurated either as a Analogue or
> Digital using the INn_MODE registers.
> 
> Signed-off-by: Inha Song <ideal.song@samsung.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
