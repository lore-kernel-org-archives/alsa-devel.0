From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: When will Realtek High-Defintion audio codec ALC282 be
	supported?
Date: Wed, 11 Jul 2012 23:05:04 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F81560FB@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 00F6F24692
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2012 01:05:09 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm going to have a platform with Realtek HDA ALC282 codec. But the driver has no support for ALC282 now. Does anybody know when ALC282 will be supported?

I saw that another Realtek ALC280 is supported by just adding the codec id and still using 'patch_alc269'. I wonder if ALC282 can also be supported in this way if it's similar enough to other ALC2XX codecs. Could anyone share some idea about this?

Thanks
Mengdong
