From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v8 00/10] soundwire: Add multi link support
Date: Tue, 7 Aug 2018 12:21:45 +0530
Message-ID: <20180807065145.GH2395@vkoul-mobl>
References: <1532682857-604-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id B37E926786B
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2018 08:51:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1532682857-604-1-git-send-email-shreyas.nc@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shreyas NC <shreyas.nc@intel.com>
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

On 27-07-18, 14:44, Shreyas NC wrote:
> Currently, in the SoundWire subsystem, the concept of stream is limited
> to a Master and one or more Slaves(Codecs). This series aims to add
> support for multiple Master(s) sharing the same reference clock and
> synchronized in the hardware.

Applied all, thanks

-- 
~Vinod
