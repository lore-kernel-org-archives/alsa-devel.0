From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: How to clear the ALSA audio settings remembered by
	system?
Date: Thu, 27 Jun 2013 06:49:42 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F80127A004@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 500D22619FA
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 08:49:52 +0200 (CEST)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Could anyone tell me how to clear the ALSA audio settings remembered by system?

I change some audio codec settings by amixer. And it seems the ALSA has remembered these settings and apply on next boot. And these will change my test result.
How can I let system forgot these changes?

Many thanks
Mengdong
