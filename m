From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Audigy 2 Support for SPDIF AC3 non-audio data.
Date: Wed, 27 Aug 2003 02:05:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F4C03DF.4010709@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I would like to help get this feature working on the Audigy 2.
Can anyone help me by giving me details about what the current status is?
What is on the TODO list in order to get it to work?
Hints on DSP commands to help testing?

There are two things that I think we need to test.
1) Samples passed from the Computer to the DSP need to be passed unchanged.
2) Samples passed from the DSP to the SPDIF socket need to be passed 
unchanged.

Can anybody give me any info on how to do these tests.
I did these tests previously with a SB Live and fixed some bugs in that, 
so I would like to do the same again with the Audigy2.

Please help

James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
