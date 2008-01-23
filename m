From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: alsa-lib(1.0.12) crash
Date: Wed, 23 Jan 2008 11:41:52 +0100
Message-ID: <1201084912.28750.1232794249@webmail.messagingengine.com>
References: <BAY110-W8FF5770A5F9D45909EF24C93F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 7FFAC243F9
	for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2008 11:41:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <BAY110-W8FF5770A5F9D45909EF24C93F0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cliff Cai <xcahua@hotmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cliff Cai wrote:
>      Source :  [ /usr/lib/libasound.so.2 + 0x46da6 ]
>    4 Target :  [ /usr/lib/libasound.so.2 + 0x46d9a ]

Please show this trace with an alsa-lib that hasn't its debug
information stripped out.

Does this still happen with alsa-lib 1.0.15?


Regards,
Clemens
