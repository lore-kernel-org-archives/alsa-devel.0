From: Mike Hearn <mike@plan99.net>
Subject: Re: Re: Change processname for dmix/dsnoop process
Date: Tue, 04 Oct 2005 15:04:53 +0100
Message-ID: <43428C05.7000201@plan99.net>
References: <433D491A.8070700@vidsoft.de>	<s5hzmpulit5.wl%tiwai@suse.de>	<pan.2005.10.01.23.13.56.451320@plan99.net> <s5h3bnheekv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3bnheekv.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: crazney@transgaming.com
Cc: alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi David,

Long time no see! If you're ever in England again make sure to drop me a 
line.

Anyway, I remember you showed me a syscall to change the process name - 
do you have a function that could be included in ALSA so the forked dmix 
process can be more obvious?

thanks -mike

Takashi Iwai wrote:

>At Sun, 02 Oct 2005 00:13:56 +0100,
>Mike Hearn wrote:
>  
>
>>On Fri, 30 Sep 2005 16:41:10 +0200, Takashi Iwai wrote:
>>    
>>
>>>Well, changing the process name in run time is very tricky on Linux. In
>>>other words: no proper way.
>>>      
>>>
>>Are you sure? I thought there was a syscall for it.
>>    
>>
>
>Then I'd be happy to change the code.  Could you give a pointer?
>
>
>Takashi
>
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
