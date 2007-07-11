From: Fausto Carvalho Marques SIlva <fausto@tse.gov.br>
Subject: Setting audio channels on ICH5 with SALSA
Date: Wed, 11 Jul 2007 17:04:45 -0300
Message-ID: <469537DD.3020901@tse.gov.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dexter.tse.gov.br (dexter.tse.gov.br [200.252.157.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 33FB0103926
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 22:08:28 +0200 (CEST)
Received: from dexter.tse.gov.br (localhost.tse.gov.br [127.0.0.1])
	by nod32.tse.gov.br (Postfix) with ESMTP id 3E109FD3A7
	for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2007 17:08:25 -0300 (BRT)
Received: from webmail.tse.gov.br (webmail.tse.gov.br [10.28.1.25])
	by dexter.tse.gov.br (Postfix) with ESMTP id 3BF8DFD1D5
	for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2007 17:08:25 -0300 (BRT)
Received: from webmail.tse.gov.br (localhost.localdomain [127.0.0.1])
	by nod32.tse.gov.br (Postfix) with ESMTP id 250F314C0D9
	for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2007 17:08:25 -0300 (BRT)
Received: from [10.28.219.33] (unknown [10.28.219.33])
	by webmail.tse.gov.br (Postfix) with ESMTP id 22F1514C054
	for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2007 17:08:25 -0300 (BRT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Setting audio channels on ICH5 with SALSA generates and: EINVAL
Numbers of channels is 1. Does anyone have some ideias?? ( on ICH6 and 
ICH7 works well)
thanks...
Fausto Carvalho Marques Silva
