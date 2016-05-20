From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] ASoC: wm8985: add register
	definitions for WM8758
Date: Fri, 20 May 2016 16:54:18 +0100
Message-ID: <20160520155418.GP1646@localhost.localdomain>
References: <1463489334-17549-1-git-send-email-petr@barix.com>
 <1463489334-17549-2-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 10502266588
 for <alsa-devel@alsa-project.org>; Fri, 20 May 2016 17:54:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1463489334-17549-2-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>
Cc: plamen@barix.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 17, 2016 at 02:48:53PM +0200, Petr Kulhavy wrote:
> The WM8758 chip is almost identical to WM8985 with the difference that it
> doesn't feature the AUX input. This patch adds the register definitions
> for WM8758 specific bit fields to the header file.
> 
> Signed-off-by: Petr Kulhavy <petr@barix.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
