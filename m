From: "Ash Willis" <ashwillis@programmer.net>
Subject: Digigram ISA cards
Date: Wed, 25 Apr 2007 08:00:12 -0500
Message-ID: <20070425130012.7A8381F50B1@ws1-2.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BDAF249BD
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2007 15:03:00 +0200 (CEST)
Received: from unknown (unknown [192.168.8.90])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	C69181800D50
	for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2007 13:02:57 +0000 (GMT)
Content-Disposition: inline
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

Hi, I'm thinking about trying to write a driver for some old Digigram cards
soon, namely the PCX11 and PCX9. I might be wrong but it seems these cards
natively support MPEG layers I and II and only actually support PCM by
re-encoding in-driver.
Does alsa-lib support MPEG conversions?
Are there examples of drivers that already do this type of thing?

Please forgive my ignorance. I grepped the sources and didn't find too much
info.

Ash

=
