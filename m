From: "John L. Utz III" <john.utz@dmx.com>
Subject: how to 'alias' a mixer element?
Date: Tue, 7 Aug 2007 15:11:27 -0700
Message-ID: <20070807151127.23792ef1@jutz-fc6.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id D3D92243E1
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Aug 2007 00:06:52 +0200 (CEST)
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

Hello;

If one had a mixer item called 'Surround' and one really wanted to
access it as an item called 'Rear' instead of using the
existing name 'Surround', would it be possible to create a virtual
control called Rear that just maps directly to Surround?

tnx!

johnu
