From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [tinycompress] [PATCH] build: Fix make distcheck
Date: Thu, 8 Oct 2015 11:07:51 +0000
Message-ID: <1444302471.25504.81.camel@intel.com>
References: <1444300888-30059-1-git-send-email-arun@accosted.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 667152617C6
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 13:08:18 +0200 (CEST)
In-Reply-To: <1444300888-30059-1-git-send-email-arun@accosted.net>
Content-Language: en-US
Content-ID: <E6D348DF785A2044BC61B74E4C35F819@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "arun@accosted.net" <arun@accosted.net>
Cc: "git@arunraghavan.net" <git@arunraghavan.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On Thu, 2015-10-08 at 11:41 +0100, arun@accosted.net wrote:
> From: Arun Raghavan <git@arunraghavan.net>
> 
> srcdir may not be the same as builddir, so use the correct variable for
> the include path.

Applied, thanks

-- 
~Vinod
