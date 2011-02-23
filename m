From: "Bensaid, Selma" <selma.bensaid@intel.com>
Subject: : Question ASoC driver without Codec driver?
Date: Wed, 23 Feb 2011 09:29:41 +0000
Message-ID: <2A84145621092446B6659B8A0F28E26F4703F09682@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 98552103810
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 10:30:01 +0100 (CET)
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Benavoli,
	PatrickX" <patrickx.benavoli@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to find out if it's possible to implement an ASoC driver 
without a codec driver.

I'm implementing a ASoC driver for BT/FM WL1273, where the FM WL1273 control 
interface is based on V4L2 since since we use the Combined Interface 
Mode (The host controls both the BT and the FM Radio through the BT HCI host interface).

Thanks for your help.

Selma.


---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
