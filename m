From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] ASoC: wm8782: add support for
	regulators
Date: Mon, 8 Oct 2018 10:48:25 +0100
Message-ID: <20181008094825.GV1653@imbe.wolfsonmicro.main>
References: <20181003193436.5281-1-daniel@zonque.org>
 <20181003193436.5281-2-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id E8146267783
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2018 11:48:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20181003193436.5281-2-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: tiwai@suse.de, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 03, 2018 at 09:34:36PM +0200, Daniel Mack wrote:
> Lookup regulators for Vdd and Vdda during probe, and enable them when the
> component is linked.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
