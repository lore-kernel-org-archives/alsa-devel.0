From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to branch from WDM to ALSA fastest way??
Date: Mon, 26 Apr 2004 18:33:37 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404261832060.25756-100000@studcom.urz.uni-halle.de>
References: <609327339.19981112025636@pisem.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <609327339.19981112025636@pisem.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ns <neslon@pisem.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

ns wrote:
> I have WDM driver for our lab's own propertiary sound
> card(ADAT+SPDIF+DB...) and wanna write ALSA drv.
> I have linux w/kernel 2.4.20 (original).
>
> I know that I must patch kernel for ALSA and write ALSA driver.
> HOw to do it fastest?

look into alsa-kernel/Documentation/DocBook/writing-an-alsa-driver


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
