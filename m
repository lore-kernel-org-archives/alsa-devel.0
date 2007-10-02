From: Timur Tabi <timur@freescale.com>
Subject: Re: ASOC: Best way to get private data from machine
 driver to the other drivers?
Date: Tue, 02 Oct 2007 11:50:51 -0500
Message-ID: <470276EB.4060605@freescale.com>
References: <46FD6EAA.5050801@freescale.com>	
	<1191236021.3318.41.camel@localhost.localdomain>	
	<47015446.9010707@freescale.com>
	<1191343248.12060.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id D4E02243CB
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Oct 2007 18:50:55 +0200 (CEST)
In-Reply-To: <1191343248.12060.21.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> On Mon, 2007-10-01 at 15:10 -0500, Timur Tabi wrote:
>> Liam Girdwood wrote:
>>
>>> Could you have a look at the V2 i.mx31 SSI driver and let me know if we
>>> need further changes for better dts support.
>> I'll do that.  However, I still have the same problem - without a git-http 
>> interface, my ability to "work with" that repository is limited.  Can you 
>> create a repo on kernel.org?  I have git better access to that site.
>>
> 
> Do you know who would be the best person to ask for this ?

I take it that enabling git-http access is not an option?  Normally, that 
would be easier than getting an account on kernel.org.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
