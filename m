From: "Bensaid, Selma" <selma.bensaid@intel.com>
Subject: ASoC SSP Driver Question
Date: Mon, 10 Jan 2011 10:47:33 +0000
Message-ID: <2A84145621092446B6659B8A0F28E26F47005A34FF@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BC022441A
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 11:48:13 +0100 (CET)
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
Cc: "Le Gall, Louis" <louis.le.gall@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm working on ASoC driver for TI WL1273 (BT/FM) using the Bulverde SSP fro=
m IPGEAR peripheral. I have seen that a pxa_ssp driver already exists howev=
er I'm not if we have to use it as is it and adapt our SSP PCI driver to In=
terface with the pxa-ssp, or can we propose an "intel_ssp" ASoC driver?

Thanks,

Selma.

Selma BENSAID
UMG/MIPE/WSIV=A0 Software Team
Office:=A0=A0=A0 +33 (0)1 72 21 04 69
Mobile:=A0 +33 (0)6 22 21 31 56
Inet : 8 222 0469
mailto:selma.bensaid@intel.com
Intel Corp.
134, av du G=E9n=E9ral Eisenhower
31023 TOULOUSE Cedex 1
France




---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
