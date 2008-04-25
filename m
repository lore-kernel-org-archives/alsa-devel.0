From: Sean Thayne <sthayne@summitmediagroupllc.com>
Subject: Re: How can you tell if the speaker jack on your	sound
 card has anything plugged into it???
Date: Fri, 25 Apr 2008 14:53:17 -0600
Message-ID: <481244BD.3060501@summitmediagroupllc.com>
References: <48123137.70107@summitmediagroupllc.com>
	<20080425194917.GA26621@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail46.opentransfer.com (mail46.opentransfer.com
	[76.162.254.46]) by alsa0.perex.cz (Postfix) with SMTP id 96379247E0
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 22:53:28 +0200 (CEST)
In-Reply-To: <20080425194917.GA26621@sirena.org.uk>
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

How would one go about getting this info? I'm trying to create a 
monitoring tool for a specific sound card, so the driver's standardized...

Mark Brown wrote:
> On Fri, Apr 25, 2008 at 01:29:59PM -0600, Sean Thayne wrote:
>
>   
>>       I was talking with some users in the irc channel in the free node, 
>> and was hoping to find a way to get the information about weither or not 
>> anything was plugged into the sound card, I've seen this feature with 
>> windows vista. I search thru a bunch of documentation sites and also 
>> scanned the /proc & /sys to no avail...
>>     
>
> There's currently no standard way of getting this information from user
> space even where the hardware provides it.
>
>
>   

-- 
Sean Thayne
Summit Media Group LLC.
5532 Lillehammer Lane, Suite 300
Park City, UT 84098
T: (435) 575-0610 ext 115
F: (435) 615-9979
E: sthayne@smgroupllc.com <mailto:sthayne@smgroupllc.com>
W: http://www.smgroupllc.com
