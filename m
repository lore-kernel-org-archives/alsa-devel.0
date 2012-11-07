From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [asoc:topic/atmel 7/7] ERROR: Input tree has
 errors, aborting (use -f to force output)
Date: Wed, 07 Nov 2012 11:45:50 +0800
Message-ID: <5099D96E.9010702@atmel.com>
References: <5098e341.O6MhFjJV2ViFIEza%yuanhan.liu@linux.intel.com>
 <20121106105856.GA17982@localhost>
 <20121106111246.GA10080@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id B80D8264F1A
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 04:45:56 +0100 (CET)
In-Reply-To: <20121106111246.GA10080@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Fengguang Wu <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark Brown,

On 11/6/2012 19:12, Mark Brown wrote:
> On Tue, Nov 06, 2012 at 06:58:56PM +0800, Fengguang Wu wrote:
>
>> ERROR (duplicate_label): Duplicate label 'ssc0' on /ahb/apb/ssc@fffa0000 and /ahb/apb/ssc@fff9c000
>> ERROR: Input tree has errors, aborting (use -f to force output)
>
> Reverted.

Resend this patch with the error fixed.

BRs,
Bo Shen
