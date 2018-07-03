From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3] ASoC: Intel: Boards: Add GLK Realtek
 Maxim I2S machine driver
Date: Tue, 3 Jul 2018 14:12:57 -0500
Message-ID: <e532f50d-3c29-d491-48b8-4c7b7650f647@linux.intel.com>
References: <1529416777-25675-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id E765A2673E1
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 21:12:59 +0200 (CEST)
In-Reply-To: <1529416777-25675-1-git-send-email-naveen.m@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen Manohar <naveen.m@intel.com>, alsa-devel@alsa-project.org
Cc: harshapriya.n@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org



On 06/19/2018 08:59 AM, Naveen Manohar wrote:
> Patch adds Geminilake I2S machine driver which uses following codecs:
> RT5682 and MAX98357A.
>
> Signed-off-by: Naveen Manohar <naveen.m@intel.com>
> Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
> v1->v2: reverse xmas tree alignment of var declaration, Add Acked-by.
> v2->v3: corrected: platform-name for echo-ref dai & change-log position.
Humm, wondering what happened to this patch. Mark, in case you were 
waiting for my ack here is it again.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
